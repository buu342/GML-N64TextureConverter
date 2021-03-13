#include <windows.h>
#include <Shlobj.h>
#include <string>
#include "main.h"

#define DLL extern "C" __declspec(dllexport)
#define popup(a) MessageBox(NULL, a, TEXT("Message"), MB_OK)
#define popup_buf(a) MessageBox(NULL, a.c_str(), TEXT("Message"), MB_OK)

using std::wstring;
using std::string;

static wstring from_gmlstring(const string str) 
{
    int len = MultiByteToWideChar(CP_UTF8, 0, str.c_str(), -1, NULL, 0)-1;
    std::wstring ret(len, 0);
    MultiByteToWideChar(CP_UTF8, 0, str.c_str(), -1, &ret[0], len);
    return ret;
}

static string to_gmlstring(const wstring str)
{
    int len = WideCharToMultiByte(CP_UTF8, 0, &str[0], (int)str.size(), NULL, 0, NULL, NULL);
    std::string ret( len, 0 );
    WideCharToMultiByte(CP_UTF8, 0, &str[0], (int)str.size(), &ret[0], len, NULL, NULL);
    return ret;
}

static string add_slash(const string& dir)
{
    if (dir.empty() || *dir.rbegin() != '\\') return dir + '\\';
    return dir;
}

DLL double open_program(const char *path)
{
    wstring wpath = from_gmlstring(path);
	return (ShellExecute(NULL, L"open", wpath.c_str(), NULL, NULL, SW_SHOW) > (HINSTANCE)32);
}

DLL char* open_directory(const char *caption, const char *start) 
{
    wstring cap = from_gmlstring(caption);
    wstring dir = (start != NULL) ? from_gmlstring(start) : L"";
    BROWSEINFOW bi = { 0 };
    LPITEMIDLIST pidl = NULL;
    wchar_t buffer[MAX_PATH];

    bi.hwndOwner = GetForegroundWindow();
    bi.pszDisplayName = buffer;
    bi.pidlRoot = NULL;
    bi.lpszTitle = cap.c_str();
    bi.ulFlags = BIF_RETURNONLYFSDIRS | BIF_NEWDIALOGSTYLE | BIF_NONEWFOLDERBUTTON;
    bi.lpfn = NULL;

    if ((pidl = SHBrowseForFolderW(&bi)) != NULL) {
        wchar_t full_folder_selection[MAX_PATH];
        SHGetPathFromIDListW(pidl, full_folder_selection);
        string result = add_slash(to_gmlstring(full_folder_selection));
        CoTaskMemFree(pidl); 
        return (char *)result.c_str();
    }

    return "";
}

DLL double file_text_open_write(const char* path)
{
	return 3;
}

DLL double file_text_write_string(const double file, const char* str)
{
	return 4;
}

DLL double file_text_writeln(const double file)
{
	return 5;
}

DLL double file_text_close(const double file)
{
	return 6;
}

DLL double file_bin_open(const char* path, const double mode)
{
	return 7;
}

DLL double file_bin_write_byte(const double file, const double byte)
{
	return 8;
}

DLL double file_bin_write_word(const double file, const double word)
{
	return 9;
}

DLL double file_bin_write_dword(const double file, const double dword)
{
	return 10;
}

DLL double file_bin_close(const double file)
{
	return 11;
}
