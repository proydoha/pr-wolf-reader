class PR_WR_SectorTools
{
    static play void RaiseCeiling()
    {
        for (int i = 0; i < level.sectors.Size(); i++)
        {
            Sector s = level.sectors[i];
            double distance = s.ceilingplane.PointToDist(s.centerspot, 64 * 10);
            s.MoveCeiling(640, distance, -1, 1, false);
        }
    }

    static play void ChangeLevelIteration(PR_WR_GameMapsContainer mapContainer, uint iteration, int mapNum, string wallPrefix)
    {
        if (mapNum >= mapContainer.gamemaps.Size()) { return; }
        Sector s = level.sectors[iteration];
        uint cellValue = mapContainer.gamemaps[mapNum].planes[0].values[iteration];
        if (cellValue > 0 && cellValue < 64)
        {
            double distance = s.floorplane.PointToDist(s.centerspot, 64);
            s.MoveFloor(64, distance, -1, 1, false, true);
            for (int i = 0; i < s.lines.Size(); i++)
            {
                Line l = s.lines[i];
                uint textureIndex = cellValue * 2 - 2;
                string textureName = wallPrefix..String.Format("%04d", textureIndex);
                TextureID texId = TexMan.CheckForTexture(textureName);
                for (int j = 0; j < l.sidedef.Size(); j++)
                {
                    if (!l.sidedef[j]) { continue; }
                    l.sidedef[j].SetTexture(Side.Bottom, texId);
                }
            }
        }
        else
        {
            double distance = s.floorplane.PointToDist(s.centerspot, 0);
            s.MoveFloor(64, distance, -1, -1, false, true);
        }
    }
}
