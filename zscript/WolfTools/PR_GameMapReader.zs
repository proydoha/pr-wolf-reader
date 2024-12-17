class PR_GameMapReader
{
    static PR_GameMapsContainer Read(PR_ByteBuffer buffer, PR_MapHead maphead)
    {
        PR_GameMapsContainer decodedMaps = PR_GameMapsContainer.Create();

        for (uint i = 0; i < uint(maphead.mapOffsets.Size()); i++)
        {
            uint offset = maphead.mapOffsets[i];
            if (offset < 1) {
                continue;
            }

            PR_GameMapHeader header = PR_GameMapHeader.Create(buffer, maphead.mapOffsets[i]);

            PR_ByteBuffer plane0CarmackEncoded = buffer.Subarray(header.plane0Offset, header.plane0Offset + header.plane0Size);
            PR_ByteBuffer plane0RlewEncoded = PR_CarmackDecoder.Decode(plane0CarmackEncoded);
            PR_ByteBuffer plane0RlewDecoded = PR_RlewDecoder.Decode(plane0RlewEncoded, maphead.rlewTag);

            PR_ByteBuffer plane1CarmackEncoded = buffer.Subarray(header.plane1Offset, header.plane1Offset + header.plane1Size);
            PR_ByteBuffer plane1RlewEncoded = PR_CarmackDecoder.Decode(plane1CarmackEncoded);
            PR_ByteBuffer plane1RlewDecoded = PR_RlewDecoder.Decode(plane1RlewEncoded, maphead.rlewTag);

            PR_ByteBuffer plane2CarmackEncoded = buffer.Subarray(header.plane2Offset, header.plane2Offset + header.plane2Size);
            PR_ByteBuffer plane2RlewEncoded = PR_CarmackDecoder.Decode(plane2CarmackEncoded);
            PR_ByteBuffer plane2RlewDecoded = PR_RlewDecoder.Decode(plane2RlewEncoded, maphead.rlewTag);

            PR_GameMap gamemap = PR_GameMap.Create(header, plane0RlewDecoded, plane1RlewDecoded, plane2RlewDecoded);

            decodedMaps.AddMap(gamemap);
        }
        return decodedMaps;
    }
}
