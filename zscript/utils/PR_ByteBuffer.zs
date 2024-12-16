class PR_ByteBuffer
{
    Array<int> bytes;

    static PR_ByteBuffer Create(uint size)
    {
        PR_ByteBuffer buffer = new("PR_ByteBuffer");
        for (uint i = 0; i < size; i++)
        {
            buffer.bytes.push(0);
        }
        return buffer;
    }

    static PR_ByteBuffer CreateFromString(string stringBuffer)
    {
        uint bufferSize = stringBuffer.Length();

        PR_ByteBuffer buffer = PR_ByteBuffer.Create(bufferSize);
        for (uint i = 0; i < bufferSize; i++)
        {
            buffer.bytes[i] = stringBuffer.ByteAt(i);
        }
        return buffer;
    }

    uint ReadUInt8(int offset)
    {
        return bytes[offset];
    }

    uint ReadUInt16LE(int offset)
    {
        return bytes[offset] | (bytes[offset + 1] << 8);
    }

    uint ReadUInt32LE(int offset)
    {
        return bytes[offset] | (bytes[offset + 1] << 8) | (bytes[offset + 2] << 16) | (bytes[offset + 3] << 24);
    }

    void DumpToConsoleHex()
    {
        int pos = 0;
        int offsets = 0;
        string stringToPrint = "00000000";
        console.Printf("Address  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F");
        while (pos < bytes.Size())
        {
            stringToPrint = stringToPrint .. " " .. String.Format("%02x", bytes[pos]);
            if ((pos + 1) % 16 == 0)
            {
                console.Printf(stringToPrint);
                offsets += 10;
                stringToPrint = "" .. String.Format("%08d", offsets);
            }
            pos++;
        }
        if ((pos) % 16 != 0)
        {
            console.Printf(stringToPrint);
        }
    }

    void DumpToConsoleInt()
    {
        int pos = 0;
        int offsets = 0;
        string stringToPrint = "00000000";
        console.Printf("Address   0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F");
        while (pos < bytes.Size())
        {
            stringToPrint = stringToPrint .. " " .. String.Format("%03i", bytes[pos]);
            if ((pos + 1) % 16 == 0)
            {
                console.Printf(stringToPrint);
                offsets += 10;
                stringToPrint = "" .. String.Format("%08d", offsets);
            }
            pos++;
        }
        if ((pos) % 16 != 0)
        {
            console.Printf(stringToPrint);
        }
    }
}
