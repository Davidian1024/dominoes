'Library "v30/bslDefender.brs"

sub Main()
    print "Entering sub Main()"

    m.bitmapFont = LoadBitmapFont()

    manifest = ReadAsciiFile("pkg:/manifest")
    lines = manifest.Split(chr(10))
    aa = {}
    for each line in lines
        if line <> ""
            entry = line.Split("=")
            aa.AddReplace(entry[0],entry[1].Trim())
        end if
    end for 
    print aa

    m.mainScreen = CreateObject("roScreen", true, 1280, 720)
    print m.mainScreen

    screen = m.mainScreen
    width = 620
    height = 50
    text = "Loading dominoes..."

    leftX = Cint((screen.GetWidth() - width) / 2)
    topY = Cint((screen.GetHeight() - height) / 2)
    xt = leftX + int(width / 2) - (Len(text) * 13) / 2 
    yt = topY + height / 2 - 15
    m.mainScreen.SwapBuffers()
    screen.DrawRect(0, 0, 1280, 720, &hFFFF55FF)
    screen.DrawRect(leftX, topY, width, height, &hFF)
    m.bitmapFont.write(screen, text, xt, yt, 2.0)
    'DrawBorder(screen, width, height, &hFFFFFFFF, 0)
    m.Tile_Graphics = CreateObject("roBitmap", "pkg:/assets/images/tile_graphics.png")
    m.Vertical_Tile = CreateObject("roRegion",Tile_Graphics,1,1,39,77)
    m.Vertical_Square_1 = CreateObject("roRegion",Tile_Graphics,42,4,33,33)
    m.Vertical_Square_12 = CreateObject("roRegion",Tile_Graphics,217,42,33,33)
    
    'screen.drawscaledobject(100, 420, 2, 2, Vertical_Tile)
    'screen.drawscaledobject(100+(3*2), 420+(3*2), 2, 2, Vertical_Square_12)
    'screen.drawscaledobject(100+(3*2), 420+(41*2), 2, 2, Vertical_Square_1)

    'Need to figure out how to reference whatever "m." is from a function like RenderTile.
    RenderTile(100,420,2,13,13,m)
    m.mainScreen.SwapBuffers()

    Sleep(100000)

    print "Exiting sub Main()"
end sub

Function RenderTile(xOffset as integer, yOffset as integer, ScaleFactor as integer, Value0 as integer, Value1 as integer, some_object as object) as Dynamic
    screen.drawscaledobject(xOffset, yOffset, ScaleFactor, ScaleFactor, some_object.Vertical_Tile)
    screen.drawscaledobject(xOffset+(3*ScaleFactor), yOffset+(3*ScaleFactor), ScaleFactor, ScaleFactor, some_object.Vertical_Square_12)
    screen.drawscaledobject(xOffset+(3*ScaleFactor), yOffset+(41*ScaleFactor), ScaleFactor, ScaleFactor, some_object.Vertical_Square_1)
End Function
