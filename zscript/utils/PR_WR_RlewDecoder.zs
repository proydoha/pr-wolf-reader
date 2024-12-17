class PR_WR_RlewDecoder
{
    static PR_WR_ByteBuffer Decode(PR_WR_ByteBuffer buffer, uint rlewTag)
    {
        uint decompressedDataLength = buffer.ReadUInt16LE(0);
        PR_WR_ByteBuffer compressedDataBuffer = buffer.Subarray(2, buffer.Size());
        PR_WR_ByteBuffer decompressedData = PR_WR_ByteBuffer.Create(decompressedDataLength);

        uint outputOffset = 0;
        uint inputOffset = 0;
        while (outputOffset < decompressedDataLength)
        {
            uint word = compressedDataBuffer.ReadUInt16LE(inputOffset);
            inputOffset += 2;

            if (word == rlewTag)
            {
                uint w1 = compressedDataBuffer.ReadUInt16LE(inputOffset);
                inputOffset += 2;
                uint w2 = compressedDataBuffer.ReadUInt16LE(inputOffset);
                inputOffset += 2;

                for (uint i = 0; i < w1; i++)
                {
                    decompressedData.WriteUInt16LE(w2, outputOffset);
                    outputOffset += 2;
                }
            }
            else
            {
                decompressedData.WriteUInt16LE(word, outputOffset);
                outputOffset += 2;
            }
        }

        return decompressedData;
    }
}
