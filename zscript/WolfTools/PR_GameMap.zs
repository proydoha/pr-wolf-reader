class PR_GameMap
{
    PR_GameMapHeader header;

    PR_ByteBuffer plane0Buffer;
    PR_ByteBuffer plane1Buffer;
    PR_ByteBuffer plane2Buffer;

    Array<uint> plane0;
    Array<uint> plane1;
    Array<uint> plane2;

    static PR_GameMap Create(
        PR_GameMapHeader header,
        PR_ByteBuffer plane0Buffer,
        PR_ByteBuffer plane1Buffer,
        PR_ByteBuffer plane2Buffer
    )
    {
        PR_GameMap gamemap = new("PR_GameMap");

        gamemap.header = header;
        gamemap.plane0Buffer = plane0Buffer;
        gamemap.plane1Buffer = plane1Buffer;
        gamemap.plane2Buffer = plane2Buffer;

        for (uint i = 0; i < plane0Buffer.Size() / 2; i++)
        {
            gamemap.plane0.push(plane0Buffer.ReadUInt16LE(i * 2));
        }
        for (uint i = 0; i < plane1Buffer.Size() / 2; i++)
        {
            gamemap.plane1.push(plane1Buffer.ReadUInt16LE(i * 2));
        }
        for (uint i = 0; i < plane2Buffer.Size() / 2; i++)
        {
            gamemap.plane2.push(plane2Buffer.ReadUInt16LE(i * 2));
        }

        return gamemap;
    }

    uint GetPlane0Value(uint rowIndex, uint columnIndex)
    {
        return plane0[CalculateIndex(rowIndex, columnIndex)];
    }

    uint GetPlane1Value(uint rowIndex, uint columnIndex)
    {
        return plane1[CalculateIndex(rowIndex, columnIndex)];
    }

    uint GetPlane2Value(uint rowIndex, uint columnIndex)
    {
        return plane2[CalculateIndex(rowIndex, columnIndex)];
    }

    void DebugPrintPlane0()
    {
        for (int i = 0; i < header.height; i++)
        {
            string mapRow = "";
            for (int j = 0; j < header.width; j++)
            {
                mapRow = mapRow .. " " .. String.Format("%03i", GetPlane0Value(j, i));
            }
            console.printf(mapRow);
        }
    }

    void DebugPrintPlane1()
    {
        for (int i = 0; i < header.height; i++)
        {
            string mapRow = "";
            for (int j = 0; j < header.width; j++)
            {
                mapRow = mapRow .. " " .. String.Format("%03i", GetPlane1Value(j, i));
            }
            console.printf(mapRow);
        }
    }

    void DebugPrintPlane2()
    {
        for (int i = 0; i < header.height; i++)
        {
            string mapRow = "";
            for (int j = 0; j < header.width; j++)
            {
                mapRow = mapRow .. " " .. String.Format("%03i", GetPlane2Value(j, i));
            }
            console.printf(mapRow);
        }
    }

    private uint CalculateIndex(uint rowIndex, uint columnIndex)
    {
        return columnIndex * header.height + rowIndex;
    }
}
