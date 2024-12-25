class PR_WR_GameMap
{
    PR_WR_GameMapHeader header;

    Array<PR_WR_Plane> planes;

    static PR_WR_GameMap Create(
        PR_WR_GameMapHeader header,
        PR_WR_Plane plane0,
        PR_WR_Plane plane1,
        PR_WR_Plane plane2
    )
    {
        PR_WR_GameMap gamemap = new("PR_WR_GameMap");

        gamemap.header = header;
        gamemap.planes.push(plane0);
        gamemap.planes.push(plane1);
        gamemap.planes.push(plane2);

        return gamemap;
    }

    uint GetPlaneValue(PR_WR_Plane plane, uint rowIndex, uint columnIndex)
    {
        return plane.values[CalculateIndex(rowIndex, columnIndex)];
    }

    void DebugPrintPlane(PR_WR_Plane plane)
    {
        for (uint i = 0; i < header.height; i++)
        {
            string mapRow = "";
            for (uint j = 0; j < header.width; j++)
            {
                mapRow = mapRow .. " " .. String.Format("%03i", GetPlaneValue(plane, j, i));
            }
            console.printf(mapRow);
        }
    }

    private uint CalculateIndex(uint rowIndex, uint columnIndex)
    {
        return columnIndex * header.height + rowIndex;
    }
}
