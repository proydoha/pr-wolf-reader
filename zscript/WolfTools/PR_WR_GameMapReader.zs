class PR_WR_GameMapReader
{
    static PR_WR_GameMapsContainer Read(PR_WR_ByteBuffer buffer, PR_WR_MapHead maphead)
    {
        PR_WR_GameMapsContainer decodedMaps = PR_WR_GameMapsContainer.Create();

        for (uint i = 0; i < uint(maphead.mapOffsets.Size()); i++)
        {
            uint offset = maphead.mapOffsets[i];
            if (offset < 1) {
                continue;
            }

            PR_WR_GameMapHeader header = PR_WR_GameMapHeader.Create(buffer, maphead.mapOffsets[i]);

            PR_WR_ByteBuffer plane0CarmackEncoded = buffer.Subarray(header.plane0Offset, header.plane0Offset + header.plane0Size);
            PR_WR_ByteBuffer plane0RlewEncoded = PR_WR_CarmackDecoder.Decode(plane0CarmackEncoded);
            PR_WR_ByteBuffer plane0RlewDecoded = PR_WR_RlewDecoder.Decode(plane0RlewEncoded, maphead.rlewTag);

            PR_WR_ByteBuffer plane1CarmackEncoded = buffer.Subarray(header.plane1Offset, header.plane1Offset + header.plane1Size);
            PR_WR_ByteBuffer plane1RlewEncoded = PR_WR_CarmackDecoder.Decode(plane1CarmackEncoded);
            PR_WR_ByteBuffer plane1RlewDecoded = PR_WR_RlewDecoder.Decode(plane1RlewEncoded, maphead.rlewTag);

            PR_WR_ByteBuffer plane2CarmackEncoded = buffer.Subarray(header.plane2Offset, header.plane2Offset + header.plane2Size);
            PR_WR_ByteBuffer plane2RlewEncoded = PR_WR_CarmackDecoder.Decode(plane2CarmackEncoded);
            PR_WR_ByteBuffer plane2RlewDecoded = PR_WR_RlewDecoder.Decode(plane2RlewEncoded, maphead.rlewTag);

            PR_WR_GameMap gamemap = PR_WR_GameMap.Create(header, plane0RlewDecoded, plane1RlewDecoded, plane2RlewDecoded);

            decodedMaps.AddMap(gamemap);
        }
        return decodedMaps;
    }
}
