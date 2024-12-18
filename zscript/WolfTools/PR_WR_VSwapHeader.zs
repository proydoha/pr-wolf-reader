class PR_WR_VSwapHeader
{
    uint totalChunks;
    uint firstSpriteChunkIndex;
    uint firstSoundChunkIndex;
    Array<int> chunkStarts;
    Array<int> chunkLengths;

    static PR_WR_VSwapHeader Create(PR_WR_ByteBuffer buffer)
    {
        PR_WR_VSwapHeader header = new("PR_WR_VSwapHeader");

        header.totalChunks = buffer.ReadUInt16LE(0);
        header.firstSpriteChunkIndex = buffer.ReadUInt16LE(2);
        header.firstSoundChunkIndex = buffer.ReadUInt16LE(4);

        uint chunkStartsInitialOffset = 6;
        for (uint i = 0; i < header.totalChunks; i++) {
            uint offset = buffer.ReadUInt32LE(chunkStartsInitialOffset + i * 4);
            header.chunkStarts.Push(offset);
        }

        for (uint i = 0; i < header.totalChunks; i++) {
            uint length = buffer.ReadUInt16LE(chunkStartsInitialOffset + header.totalChunks * 4 + i * 2);
            header.chunkLengths.Push(length);
        }

        return header;
    }
}
