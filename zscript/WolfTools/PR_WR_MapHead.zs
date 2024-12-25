class PR_WR_MapHead
{
    uint rlewTag;
    Array<uint> mapOffsets;

    static PR_WR_MapHead Create(PR_WR_ByteBuffer buffer)
    {
        PR_WR_MapHead maphead = new("PR_WR_MapHead");

        uint headerSize = 2;
        uint maxLevelCount = 100;

        maphead.rlewTag = buffer.ReadUInt16LE(0);

        for (uint i = 0; i < maxLevelCount; i++)
        {
            uint bufferOffset = headerSize + i * 4;
            if (bufferOffset + 4 >= uint(buffer.bytes.Size())) { break; }
            uint offset = buffer.ReadUInt32LE(headerSize + i * 4);
            maphead.mapOffsets.Push(offset);
        }

        return maphead;
    }
}
