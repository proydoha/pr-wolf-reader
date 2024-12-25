class PR_WolfReaderStaticHandler : StaticEventHandler
{
    PR_WR_TextureContainer container;

    override void OnRegister()
    {
        Console.Printf("[Wolf Reader] PR_WolfReaderStaticHandler is registered");

        int mapheadLump = Wads.FindLump("MAPHEAD", 0);
        int gamemapsLump = Wads.FindLump("GAMEMAPS", 0);
        int vswapLump = Wads.FindLump("VSWAP", 0);

        string mapheadLumpContents = Wads.ReadLump(mapheadLump);
        string gamemapsLumpContents = Wads.ReadLump(gamemapsLump);
        string vswapContents = Wads.ReadLump(vswapLump);

        PR_WR_ByteBuffer mapHeadBuffer = PR_WR_ByteBuffer.CreateFromString(mapheadLumpContents);
        PR_WR_ByteBuffer gamemapsBuffer = PR_WR_ByteBuffer.CreateFromString(gamemapsLumpContents);
        PR_WR_ByteBuffer vswapBuffer = PR_WR_ByteBuffer.CreateFromString(vswapContents);

        PR_WR_MapHead maphead = PR_WR_MapHeadReader.Read(mapHeadBuffer);
        PR_WR_GameMapsContainer mapContainer = PR_WR_GameMapReader.Read(gamemapsBuffer, maphead);
        PR_WR_VSwap vswap = PR_WR_VSwapReader.Read(vswapBuffer);

        container = PR_WR_TextureContainer.Create(vswap, "WOLF3DWALL", "WOLF3DSPRITE");
    }

    override void RenderOverlay(RenderEvent e)
    {
        // DebugDrawWallTextures(container);
        // DebugDrawSpriteTextures(container);
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
