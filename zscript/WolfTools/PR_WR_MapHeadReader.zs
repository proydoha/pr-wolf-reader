class PR_WR_MapHeadReader
{
    static PR_WR_MapHead Read(PR_WR_ByteBuffer buffer)
    {
        uint headerSize = 2;
        uint maxLevelCount = 100;

        uint rlewTag = buffer.ReadUInt16LE(0);
        PR_WR_MapHead maphead = PR_WR_MapHead.Create(rlewTag);

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
