Function LoadBitmapFont() As Dynamic
    print "LoadBitmapFont()"
    rsp = ReadAsciiFile("pkg:/assets/fonts/prince-fnt.xml")
    xml=CreateObject("roXMLElement")
    if not xml.Parse(rsp)
        print "Can't parse feed"
        return invalid
    else if xml.font = invalid
        print "Missing font tag"
        return invalid
    end if
    xmlChars = xml.getnamedelements("chars").getchildelements()
    bitmap=CreateObject("roBitmap", "pkg:/assets/fonts/prince-fnt.png")
    this = {}
    for each char in xmlChars
        charAttr = char.getAttributes()
        name = "chr" + charAttr["id"]
        x = val(charAttr["x"])
        y = val(charAttr["y"])
        width = val(charAttr["width"])
        height = val(charAttr["height"])
        yoffset = val(charAttr["yoffset"])
        yOff = (height + yoffset - 11)
        letter = CreateObject("roRegion",bitmap,x,y,width,height)
        this.AddReplace(name, {image: letter, yOffset: yOff})
    next
    this.write = write_text
    return this                                                                                                                                                                               
End Function

Function write_text(screen as object, text as string, x as integer, y as integer, scale = 1.0 as float) as object
    print "write_text", text
        xOff = 2 * scale
        yOff = 8 * scale
    for c = 0 to len(text) - 1
        ci = asc(text.mid(c,1))
        'Convert accented characters not supported by the font
        if (ci > 191 and ci < 199) or (ci > 223 and ci < 231) 'A
            ci = 65
        else if ci = 199 or ci = 231 'C
            ci = 67
        else if (ci > 199 and ci < 204) or (ci > 231 and ci < 236) 'E
            ci = 69
        else if (ci > 203 and ci < 208) or (ci > 235 and ci < 240) 'I
            ci = 73
        else if ci = 208 'D
            ci = 68
        else if ci = 209 or ci = 241 'N
            ci = 78
        else if (ci > 209 and ci < 215) or (ci > 241 and ci < 247)'O
            ci = 79
        else if ci = 215 'X
            ci = 88
        else if ci = 216 '0
            ci = 48
        else if (ci > 216 and ci < 221) or (ci > 248 and ci < 253) 'U
            ci = 85
        else if ci = 221 'Y
            ci = 89
        else if ci > 160
            ci = 32
        end if
        'write the letter
        letter = m.Lookup("chr" + ci.toStr())
        if letter <> invalid
            yl = y + (yOff - letter.image.GetHeight() * scale)
            screen.drawscaledobject(x, yl + letter.yOffset * scale, scale, scale, letter.image)
            x += (letter.image.GetWidth() * scale + xOff)
        end if
    next
End Function
