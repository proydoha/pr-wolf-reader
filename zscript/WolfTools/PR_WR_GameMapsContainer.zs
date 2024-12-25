class PR_WR_GameMapsContainer
{
    Array<PR_WR_GameMap> gamemaps;

    static PR_WR_GameMapsContainer Create(PR_WR_ByteBuffer buffer, PR_WR_MapHead maphead)
    {
        PR_WR_GameMapsContainer container = new("PR_WR_GameMapsContainer");

        for (int i = 0; i < maphead.mapOffsets.Size(); i++)
        {
            uint offset = maphead.mapOffsets[i];
            if (offset < 1) {
                continue;
            }

            PR_WR_GameMapHeader header = PR_WR_GameMapHeader.Create(buffer, maphead.mapOffsets[i]);

            PR_WR_Plane plane0 = PR_WR_Plane.Create(buffer, header.plane0Offset, header.plane0Size, maphead.rlewTag);
            PR_WR_Plane plane1 = PR_WR_Plane.Create(buffer, header.plane1Offset, header.plane1Size, maphead.rlewTag);
            PR_WR_Plane plane2 = PR_WR_Plane.Create(buffer, header.plane2Offset, header.plane2Size, maphead.rlewTag);

            PR_WR_GameMap gamemap = PR_WR_GameMap.Create(header, plane0, plane1, plane2);

            container.gamemaps.Push(gamemap);
        }

        return container;
    }
}
