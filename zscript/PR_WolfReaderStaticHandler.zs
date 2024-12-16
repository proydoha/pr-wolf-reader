class PR_WolfReaderStaticHandler : StaticEventHandler
{
    override void OnRegister()
    {
        Console.Printf("[Wolf Reader] PR_WolfReaderStaticHandler is registered");

        int mapheadLump = Wads.FindLump("MAPHEAD", 0);
        string mapheadLumpContents = Wads.ReadLump(mapheadLump);

        PR_ByteBuffer mapHeadBuffer = PR_ByteBuffer.CreateFromString(mapheadLumpContents);
        PR_MapHead maphead = PR_MapHeadReader.Read(mapHeadBuffer);
    }
}
