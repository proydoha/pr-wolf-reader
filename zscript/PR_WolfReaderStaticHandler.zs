class PR_WolfReaderStaticHandler : StaticEventHandler
{
    override void OnRegister()
    {
        Console.Printf("[Wolf Reader] PR_WolfReaderStaticHandler is registered");

        int mapheadLump = Wads.FindLump("MAPHEAD", 0);
        int gamemapsLump = Wads.FindLump("GAMEMAPS", 0);

        string mapheadLumpContents = Wads.ReadLump(mapheadLump);
        string gamemapsLumpContents = Wads.ReadLump(gamemapsLump);

        PR_ByteBuffer mapHeadBuffer = PR_ByteBuffer.CreateFromString(mapheadLumpContents);
        PR_ByteBuffer gamemapsBuffer = PR_ByteBuffer.CreateFromString(gamemapsLumpContents);

        PR_MapHead maphead = PR_MapHeadReader.Read(mapHeadBuffer);
        PR_GameMapReader.Read(gamemapsBuffer, maphead);
    }
}
