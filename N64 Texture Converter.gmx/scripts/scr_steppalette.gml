if (global.basetlutnum == 0)
{
    self.special[0].icon = 1
    self.special[0].text = "Import Base Palette"
    self.special[0].execute = scr_import_basepal_file
}
else
{
    self.special[0].icon = 6
    self.special[0].text = "Remove Base Palette"
    self.special[0].execute = scr_clear_basepal
}

if (global.basetlutnum == 0)
{
    if (specialcount > 1)
    {
        self.special[1].enabled = true
        self.special[2].enabled = true
    }
}
else
{
    if (specialcount > 1)
    {
        self.special[1].enabled = false
        self.special[2].enabled = false
    }
}
