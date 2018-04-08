# Nintendo 64 Texture Converter
Allows you to import .bmp, .gif, .jpg or .png's and export them as a Nintendo 64 compatible C header file.<br/>
Created in Game Maker 8. The reason for this is because Studio got rid of some useful functions, such as variable_local_exists, and as a result this code will not be compatible with Studio without some modification. Also, Game Maker 8 games are Windows XP compatible, which was important for me as that is my N64 development environment.<br/><br/>

### System Requirements
* Windows 2000 or later 
* DirectX 8 or later
* DirectX 8 compatible graphics card with at least 32MB of video memory
* Pentium or equivalent processor
* DirectX 8 compatible sound card
* 128 MB of memory or greater (noted only in official Game Maker help file documentation)
* 800×600 or greater screen resolution with 16-bit or 32-bit colors<br/><br/>

### Bugs
* Alpha masks aren't implemented yet.
* Rename button isn't implemented yet.
* File and Help buttons aren't implemented yet.<br/><br/>
* Hue, saturation and luminosity values are incorrect. Blame Game Maker.<br/><br/>

### FAQ
**Q:** Can you make this for "Operating System Here"?<br/>
**A:** Game Maker 8 only allows for the creation of Windows 2000+ exe files. Studio probably supports "Operating System Here", so if you grab the .gmk source you can convert it yourself.<br/><br/>

**Q:** Why Game Maker?<br/>
**A:** Because it was convenient at the time.<br/><br/>

**Q:** I get "Failed to initialize drawing surfaces" when I start the program!<br/>
**A:** Your computer isn't powerful enough to run the program<br/><br/>
