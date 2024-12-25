class PR_WR_SpriteHeader
{
    uint firstColumn;
    uint lastColumn;
    Array<uint> columnOffsets;
    PR_WR_ByteBuffer pixelPool;

    static PR_WR_SpriteHeader Create(PR_WR_ByteBuffer buffer)
    {
        PR_WR_SpriteHeader header = new("PR_WR_SpriteHeader");

        uint bufferPosition = 0;

        header.firstColumn = buffer.ReadUInt16LE(bufferPosition);
        bufferPosition += 2;
        header.lastColumn = buffer.ReadUInt16LE(bufferPosition);
        bufferPosition += 2;

        uint offsetCount = header.lastColumn - header.firstColumn + 1;

        for (uint i = 0; i < offsetCount; i++)
        {
            uint offset = buffer.ReadUInt16LE(bufferPosition);
            bufferPosition += 2;
            header.columnOffsets.Push(offset);
        }

        header.pixelPool = buffer.Subarray(bufferPosition, buffer.Size());

        return header;
    }
}
