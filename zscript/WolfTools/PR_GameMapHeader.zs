class PR_GameMapHeader
{
    uint plane0Offset; // Walls, floors, doors
    uint plane1Offset; // Pickups and decorations
    uint plane2Offset; // Unused in Wolfenstein 3D
    uint plane0Size; // Walls, floors, doors
    uint plane1Size; // Pickups and decorations
    uint plane2Size; // Unused in Wolfenstein 3D
    uint width;
    uint height;
    string name;
    string signature;

    static PR_GameMapHeader Create(PR_ByteBuffer buffer, uint offset)
    {
        PR_GameMapHeader header = new("PR_GameMapHeader");

        uint headerSize = 42;
        PR_ByteBuffer headerBuffer = buffer.Subarray(offset, offset + headerSize);

        header.plane0Offset = headerBuffer.ReadUInt32LE(0);
        header.plane1Offset = headerBuffer.ReadUInt32LE(4);
        header.plane2Offset = headerBuffer.ReadUInt32LE(8);
        header.plane0Size = headerBuffer.ReadUInt16LE(12);
        header.plane1Size = headerBuffer.ReadUInt16LE(14);
        header.plane2Size = headerBuffer.ReadUInt16LE(16);
        header.width = headerBuffer.ReadUInt16LE(18);
        header.height = headerBuffer.ReadUInt16LE(20);
        header.name = headerBuffer.toString(22, 38);
        header.signature = headerBuffer.toString(38, 42);

        return header;
    }

    void DebugPrint()
    {
        console.printf("name: "..name);
        console.printf("signature: "..signature);
        console.printf("width: "..width);
        console.printf("height: "..height);
        console.printf("plane0Offset: "..plane0Offset);
        console.printf("plane1Offset: "..plane1Offset);
        console.printf("plane2Offset: "..plane2Offset);
        console.printf("plane0Size: "..plane0Size);
        console.printf("plane1Size: "..plane1Size);
        console.printf("plane2Size: "..plane2Size);
    }
}
