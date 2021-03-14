/***************************************************************
                           main.cpp

The DLL entrypoint.
If you've come here to learn how to write GM DLL's, I would not
recommend as the code here is very messy and unsafe. This is 
*NOT* how you should be making a DLL. The reason I've left it in 
this state is because I just need something that works, even if
it's full of bad coding practices...
The correct thing to do would be to return the file path pointer,
but because GML forces me to return it as a double I couldn't
find a way of casting it correctly, so I opted to make the DLL
persistent by having DllMain and a global variable with the 
file handle. Maybe some other day I'll revist and clean this up...
***************************************************************/

#include <windows.h>
#include <Shlobj.h>
#include <string>
#include "main.h"


/*********************************
              Macros
*********************************/

#pragma warning(disable:4996) // Disables str:cpy unsafe

// Game Maker export type
#define DLL extern "C" __declspec(dllexport)

// Debugging macros
#define popup(a) MessageBoxW(NULL, a, L"Message", MB_OK)
#define popup_buff(a) MessageBoxW(NULL, a.c_str(), L"Message", MB_OK)

// Newline definiton 
const char newline[] = {'\r', '\n'};


/*********************************
            Namespaces
*********************************/

using std::wstring;
using std::string;


/*********************************
         Global Variables
*********************************/

HANDLE fhandle;
char exportpath[MAX_PATH];


/*==============================
    DllMain
    DLL Entry point. Needed to keep the DLL persistent 
    in memory (So that the global variables are useful).
    @param Handle to DLL module
    @param The reason for calling this function
    @param Reserved
    @returns Whether it succeeded or failed to initialize
==============================*/

BOOL WINAPI DllMain(HANDLE hinstDLL, DWORD dwReason, LPVOID lpvReserved)
{
	switch (dwReason)
	{
	case DLL_PROCESS_ATTACH:
	case DLL_THREAD_ATTACH:
	case DLL_THREAD_DETACH:
	case DLL_PROCESS_DETACH:
		break;
	}
	return TRUE;
}


/*==============================
    from_gmlstring
    Converts a GML string to wstring
    @param The GML string to convert
    @returns The string as a wstring
==============================*/

static wstring from_gmlstring(const string str) 
{
    int len = MultiByteToWideChar(CP_UTF8, 0, str.c_str(), -1, NULL, 0)-1;
    std::wstring ret(len, 0);
    MultiByteToWideChar(CP_UTF8, 0, str.c_str(), -1, &ret[0], len);
    return ret;
}


/*==============================
    to_gmlstring
    Converts a wstring back to a GML string.
    @param The wstring to convert
    @returns The wswting as a GML compatible string
==============================*/

static string to_gmlstring(const std::wstring &str)
{
    if (str.empty()) 
        return std::string();
    int len = WideCharToMultiByte(CP_UTF8, 0, &str[0], -1, NULL, 0, NULL, NULL)+1;
    std::string ret(len, 0);
    WideCharToMultiByte(CP_UTF8, 0, &str[0], -1, &ret[0], len, NULL, NULL);
    return ret;
}


/*==============================
    open_program
    Opens a program given a filepath
    @param The path of the program to open
    @returns Whether it was successful in launching
==============================*/

DLL double open_program(const char *path)
{
    wstring wpath = from_gmlstring(path);
	return (ShellExecuteW(NULL, L"open", wpath.c_str(), NULL, NULL, SW_SHOW) > (HINSTANCE)32);
}


/*==============================
    open_directory
    Opens a directory dialogue box and returns
    the selected path
    @param The caption to use
    @param The directory to start in
    @returns A string with the selected path, or ""
==============================*/

DLL char* open_directory(const char *caption, const char *start) 
{
    wchar_t buffer[MAX_PATH];
    wchar_t full_folder_selection[MAX_PATH];
    wstring cap = from_gmlstring(caption);
    wstring dir = (start != NULL) ? from_gmlstring(start) : L"";
    BROWSEINFOW bi = { 0 };
    LPITEMIDLIST pidl = NULL;

    // Initialize the BROWSEINFOW struct
    bi.hwndOwner = GetForegroundWindow();
    bi.pszDisplayName = buffer;
    bi.pidlRoot = NULL;
    bi.lpszTitle = cap.c_str();
    bi.ulFlags = BIF_RETURNONLYFSDIRS | BIF_NEWDIALOGSTYLE | BIF_NONEWFOLDERBUTTON;
    bi.lpfn = NULL;

    // Open the directory dialogue box
    pidl = SHBrowseForFolderW(&bi);
    if (pidl == NULL)
        return "";

    // Get the selected path and retrn it as a GML string
    SHGetPathFromIDListW(pidl, full_folder_selection);
    string result = to_gmlstring(full_folder_selection);
    result.copy(exportpath, MAX_PATH);
    CoTaskMemFree(pidl); 
    return exportpath;
}


/*==============================
    file_text_open_write
    Opens a text file for writing
    @param The path of the text file
    @returns 0 if success, -1 if failure
==============================*/

DLL double file_text_open_write(const char* path)
{
    wstring fpath = from_gmlstring(path);
    fhandle = CreateFileW(fpath.c_str(), GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
    if (fhandle == INVALID_HANDLE_VALUE)
        return -1;
	return 0;
}


/*==============================
    file_text_write_string
    Writes a string in a text file
    @param The file path pointer (unused)
    @param The string to write
    @returns The number of bytes written
==============================*/

DLL double file_text_write_string(double file, const char* str)
{
    DWORD written = 0;
    if (fhandle != INVALID_HANDLE_VALUE)
        WriteFile(fhandle, str, strlen(str), &written, NULL);      
    return written;
}


/*==============================
    file_text_writeln
    Writes a new line to a text file
    @param The file pointer (unused)
    @returns The number of bytes written
==============================*/

DLL double file_text_writeln(const double file)
{
    DWORD written = 0;
    if (fhandle != INVALID_HANDLE_VALUE)
        WriteFile(fhandle, newline, 2, &written, NULL);      
    return written;
}


/*==============================
    file_text_close
    Closes an open text file
    @param The file pointer (unused)
    @returns zero (unused)
==============================*/

DLL double file_text_close(const double file)
{
    if (fhandle != INVALID_HANDLE_VALUE)
        CloseHandle(fhandle);      
    return 0;
}


/*==============================
    file_bin_open
    Opens a binary file
    @param The file path
    @param The mode to open it in
    @returns 0 if success, -1 if failure
==============================*/

DLL double file_bin_open(const char* path, const double mode)
{
    DWORD winmode;
    wstring fpath;
    
    // Convert the GML mode to Win32 API's mode
    switch((int)mode)
    {
        case 0: winmode = GENERIC_READ; break;
        case 1: winmode = GENERIC_WRITE; break;
        case 2: winmode = (GENERIC_READ|GENERIC_WRITE); break;
    }

    // Open the file and return whether it was successful or not
    fpath = from_gmlstring(path);
    fhandle = CreateFileW(fpath.c_str(), winmode, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
    if (fhandle == INVALID_HANDLE_VALUE)
        return -1;
	return 0;
}


/*==============================
    file_bin_write_byte
    Writes a byte to a binary file
    @param The file pointer (unused)
    @param The byte to write
    @returns The number of bytes written
==============================*/

DLL double file_bin_write_byte(const double file, const double byte)
{
    DWORD written = 0;
    BYTE write = static_cast<BYTE>(byte);
    if (fhandle != INVALID_HANDLE_VALUE)
        WriteFile(fhandle, &write, 1, &written, NULL);      
    return written;
}


/*==============================
    file_bin_write_word
    Writes 2 bytes to a binary file
    @param The file pointer (unused)
    @param The word to write
    @returns The number of bytes written
==============================*/

DLL double file_bin_write_word(const double file, const double word)
{
    DWORD written = 0;
    WORD write = static_cast<WORD>(word);
    if (fhandle != INVALID_HANDLE_VALUE)
        WriteFile(fhandle, &write, 2, &written, NULL);      
    return written;
}


/*==============================
    file_bin_write_dword
    Writes 4 bytes to a binary file
    @param The file pointer (unused)
    @param The dword to write
    @returns The number of bytes written
==============================*/

DLL double file_bin_write_dword(const double file, const double dword)
{
    DWORD written = 0;
    DWORD write = static_cast<DWORD>(dword);
    if (fhandle != INVALID_HANDLE_VALUE)
        WriteFile(fhandle, &write, 4, &written, NULL);      
    return written;
}


/*==============================
    file_text_close
    Closes an open text file
    @param The file pointer (unused)
    @returns zero (unused)
==============================*/

DLL double file_bin_close(const double file)
{
    if (fhandle != INVALID_HANDLE_VALUE)
        CloseHandle(fhandle);      
    return 0;
}