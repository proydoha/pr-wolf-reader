class PR_WR_Plane
{
    PR_WR_ByteBuffer buffer;
    Array<int> values;

    static PR_WR_Plane Create(PR_WR_ByteBuffer buffer, uint offsetStart, uint size, uint rlewTag)
    {
        PR_WR_Plane plane = new("PR_WR_Plane");

        PR_WR_ByteBuffer carmackEncoded = buffer.Subarray(offsetStart, offsetStart + size);
        PR_WR_ByteBuffer rlewEncoded = PR_WR_CarmackDecoder.Decode(carmackEncoded);
        PR_WR_ByteBuffer rlewDecoded = PR_WR_RlewDecoder.Decode(rlewEncoded, rlewTag);

        plane.buffer = rlewDecoded;

        for (uint i = 0; i < plane.buffer.Size() / 2; i++)
        {
            plane.values.Push(plane.buffer.ReadUInt16LE(i * 2));
        }

        return plane;
    }
}
