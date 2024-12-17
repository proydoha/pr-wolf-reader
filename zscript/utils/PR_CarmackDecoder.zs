class PR_CarmackDecoder
{
    static PR_ByteBuffer Decode(PR_ByteBuffer buffer)
    {
        uint nearPointer = 0xA7;
        uint farPointer = 0xA8;

        uint decompressedDataLength = buffer.ReadUInt16LE(0);
        PR_ByteBuffer compressedDataBuffer = buffer.Subarray(2, buffer.bytes.Size());
        PR_ByteBuffer decompressedData = PR_ByteBuffer.Create(decompressedDataLength);

        uint outputOffset = 0;
        uint inputOffset = 0;
        while (outputOffset < decompressedDataLength)
        {
            uint x = compressedDataBuffer.ReadUInt8(inputOffset++);
            uint y = compressedDataBuffer.ReadUInt8(inputOffset++);

            if (x == 0 && (y == nearPointer || y == farPointer))
            {
                uint z = compressedDataBuffer.ReadUInt8(inputOffset++);
                decompressedData.WriteUInt8(z, outputOffset++);
                decompressedData.WriteUInt8(y, outputOffset++);
            }
            else if (y == nearPointer)
            {
                uint z = compressedDataBuffer.ReadUInt8(inputOffset++);
                uint pointerOffset = 2 * z;
                for (uint i = 0; i < x; i++)
                {
                    uint value = decompressedData.ReadUInt16LE(outputOffset - pointerOffset);
                    decompressedData.WriteUInt16LE(value, outputOffset);
                    outputOffset += 2;
                }
            }
            else if (y == farPointer)
            {
                uint w = compressedDataBuffer.ReadUInt16LE(inputOffset);
                inputOffset += 2;
                uint pointerOffset = 2 * w;
                for (uint i = 0; i < x; i++)
                {
                    uint value = decompressedData.ReadUInt16LE(pointerOffset + 2 * i);
                    decompressedData.WriteUInt16LE(value, outputOffset);
                    outputOffset += 2;
                }
            }
            else
            {
                decompressedData.WriteUInt16LE(y << 8 | x, outputOffset);
                outputOffset += 2;
            }
        }
        return decompressedData;
    }
}
