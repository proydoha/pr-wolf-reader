class PR_WolfReaderStaticHandler : StaticEventHandler
{
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
    }
}
