class PR_WolfReaderStaticHandler : StaticEventHandler
{
    PR_WR_TextureContainer textureContainer;
    PR_WR_GameMapsContainer mapContainer;
    int counter;
    int mode;
    int mapNum;

    string wallPrefix;
    string spritePrefix;

    bool wallTexturesDebug;
    bool spriteTexturesDebug;

    override void OnRegister()
    {
        Console.Printf("[Wolf Reader] PR_WolfReaderStaticHandler is registered");

        wallPrefix = "WOLF3DWALL";
        spritePrefix = "WOLF3DSPRITE";
        mode = PRWR_DONE;
        mapNum = 0;

        wallTexturesDebug = false;
        spriteTexturesDebug = false;

        int mapheadLump = Wads.FindLump("MAPHEAD", 0);
        int gamemapsLump = Wads.FindLump("GAMEMAPS", 0);
        int vswapLump = Wads.FindLump("VSWAP", 0);

        string mapheadLumpContents = Wads.ReadLump(mapheadLump);
        string gamemapsLumpContents = Wads.ReadLump(gamemapsLump);
        string vswapContents = Wads.ReadLump(vswapLump);

        PR_WR_ByteBuffer mapHeadBuffer = PR_WR_ByteBuffer.CreateFromString(mapheadLumpContents);
        PR_WR_ByteBuffer gamemapsBuffer = PR_WR_ByteBuffer.CreateFromString(gamemapsLumpContents);
        PR_WR_ByteBuffer vswapBuffer = PR_WR_ByteBuffer.CreateFromString(vswapContents);

        PR_WR_MapHead maphead = PR_WR_MapHead.Create(mapHeadBuffer);
        mapContainer = PR_WR_GameMapsContainer.Create(gamemapsBuffer, maphead);
        PR_WR_VSwap vswap = PR_WR_VSwap.Create(vswapBuffer);

        textureContainer = PR_WR_TextureContainer.Create(vswap, wallPrefix, spritePrefix);
    }

    override void WorldLoaded(WorldEvent e)
    {
        if (e.IsSaveGame) { return; }
        if (e.IsReopen) { return; }

        PR_WR_SectorTools.RaiseCeiling();
        counter = 0;
    }

    override void WorldTick()
    {
        if (counter >= level.sectors.Size())
        {
            mode = PRWR_DONE;
            return;
        }
        if (mode == PRWR_CHANGINGMAP)
        {
            for (int k = 0; k < 64 * 4; k++)
            {
                PR_WR_SectorTools.ChangeLevelIteration(mapContainer, counter, mapNum, wallPrefix);
                counter++;
            }
        }
    }

    override void NetworkProcess(ConsoleEvent e)
    {
        Array<string> command;
        e.Name.Split (command, ":");

        if (command[0] == "map")
        {
            mode = PRWR_CHANGINGMAP;
            counter = 0;
            mapNum = command[1].ToInt();
        }
        if (command[0] == "walltex")
        {
            wallTexturesDebug = !wallTexturesDebug;
        }
        if (command[0] == "spritetex")
        {
            spriteTexturesDebug = !spriteTexturesDebug;
        }
    }

    override void RenderOverlay(RenderEvent e)
    {
        if (wallTexturesDebug)
        {
            DebugDrawWallTextures(textureContainer);
        }
        if (spriteTexturesDebug)
        {
            DebugDrawSpriteTextures(textureContainer);
        }
    }

    private ui void DebugDrawWallTextures(PR_WR_TextureContainer container)
    {
        int textureWidth = 64;
        int textureHeight = 64;
        int columnsPerRow = Screen.GetWidth() / textureWidth;
        for (int i = 0; i < container.wallTextures.Size(); i++)
        {
            int x = (i % columnsPerRow) * textureWidth;
            int y = (i / columnsPerRow) * textureHeight;
            Screen.DrawTexture(container.wallTextures[i], false, x, y);
        }
    }

    private ui void DebugDrawSpriteTextures(PR_WR_TextureContainer container)
    {
        int textureWidth = 64;
        int textureHeight = 64;
        int columnsPerRow = Screen.GetWidth() / textureWidth;
        for (int i = 0; i < container.spriteTextures.Size(); i++)
        {
            int x = (i % columnsPerRow) * textureWidth;
            int y = (i / columnsPerRow) * textureHeight;
            Screen.DrawTexture(container.spriteTextures[i], false, x, y);
        }
    }
}
