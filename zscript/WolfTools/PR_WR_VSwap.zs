class PR_WR_VSwap
{
    PR_WR_VSwapHeader header;
    Array<PR_WR_ByteBuffer> wallChunks;
    Array<PR_WR_ByteBuffer> spriteChunks;
    Array<PR_WR_ByteBuffer> soundChunks;

    static PR_WR_VSwap Create(PR_WR_ByteBuffer buffer)
    {
        PR_WR_VSwap vswap = new("PR_WR_VSwap");
        vswap.header = PR_WR_VSwapHeader.Create(buffer);

        for (uint i = 0; i < vswap.header.totalChunks; i++) {
            PR_WR_ByteBuffer chunk = buffer.Subarray(
                vswap.header.chunkStarts[i],
                vswap.header.chunkStarts[i] + vswap.header.chunkLengths[i]
            );

            if (i >= vswap.header.firstSoundChunkIndex) {
                vswap.soundChunks.Push(chunk);
            } else if (i >= vswap.header.firstSpriteChunkIndex) {
                vswap.spriteChunks.Push(chunk);
            } else {
                vswap.wallChunks.Push(chunk);
            }
        }

        return vswap;
    }
}
