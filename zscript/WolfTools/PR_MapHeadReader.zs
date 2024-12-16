class PR_MapHeadReader
{
    static PR_MapHead Read(PR_ByteBuffer buffer)
    {
        uint headerSize = 2;
        uint maxLevelCount = 100;

        uint rlewTag = buffer.ReadUInt16LE(0);
        PR_MapHead maphead = PR_MapHead.Create(rlewTag);

        for (uint i = 0; i < maxLevelCount; i++)
        {
            uint bufferOffset = headerSize + i * 4;
            if (bufferOffset + 4 >= buffer.bytes.Size()) { break; }
            uint offset = buffer.ReadUInt32LE(headerSize + i * 4);
            maphead.levelOffsets.push(offset);
        }

        return maphead;
    }
}
