class PR_WR_TextureContainer
{
    Array<TextureId> wallTextures;
    Array<TextureId> spriteTextures;

    static PR_WR_TextureContainer Create(PR_WR_VSwap vswap, string animdefsWallPrefix, string animdefsSpritePrefix)
    {
        PR_WR_TextureContainer container = new("PR_WR_TextureContainer");

        for (int i = 0; i < vswap.wallChunks.Size(); i++)
        {
            TextureId texId = container.CreateWallTexture(vswap.wallChunks[i], animdefsWallPrefix, i);
            container.wallTextures.Push(texId);
        }

        for (int i = 0; i < vswap.spriteChunks.Size(); i++)
        {
            TextureId texId = container.CreateSpriteTexture(vswap.spriteChunks[i], animdefsSpritePrefix, i);
            container.spriteTextures.Push(texId);
        }

        return container;
    }

    private TextureId CreateWallTexture(PR_WR_ByteBuffer buffer, string animdefsWallPrefix, uint wallChunkIndex)
    {
        string textureName = animdefsWallPrefix..String.Format("%04d", wallChunkIndex);
        TextureID texId = TexMan.CheckForTexture(textureName);
        Canvas cv = TexMan.GetCanvas(textureName);

        uint width;
        uint height;
        [width, height] = TexMan.GetSize(texId);

        for (uint j = 0; j < height; j++)
        {
            for (uint i = 0; i < width; i++)
            {
                uint colorOffset = buffer.bytes[CalculateIndex(i, j, width)];
                uint color = GetColorFromPalette(colorOffset);
                cv.Dim(color, 1, i, j, 1, 1);
            }
        }

        return texId;
    }

    private TextureId CreateSpriteTexture(PR_WR_ByteBuffer buffer, string animdefsSpritePrefix, uint spriteIndex)
    {
        string textureName = animdefsSpritePrefix..String.Format("%04d", spriteIndex);
        TextureID texId = TexMan.CheckForTexture(textureName);
        Canvas cv = TexMan.GetCanvas(textureName);

        uint width;
        uint height;
        [width, height] = TexMan.GetSize(texId);
        for (uint j = 0; j < height; j++)
        {
            for (uint i = 0; i < width; i++)
            {
                uint color = GetColorFromPalette(PR_WR_Palette.colors.Size() - 1);
                cv.Dim(color, 1, i, j, 1, 1);
            }
        }

        PR_WR_Sprite sprite = PR_WR_Sprite.Create(buffer);

        for (int i = 0; i < sprite.posts.Size(); i++) {
            PR_WR_SpritePost post = sprite.posts[i];
            uint pixelPoolPosition = post.pixelPoolOffset + post.start;
            for (uint j = post.start; j < post.end; j++) {
                if (pixelPoolPosition >= uint(sprite.header.pixelPool.Size())) { break; }
                uint colorIndex = buffer.ReadUInt8(pixelPoolPosition);
                uint color = GetColorFromPalette(colorIndex);
                cv.Dim(color, 1, post.column, j, 1, 1);
                pixelPoolPosition++;
            }
        }

        return texId;
    }

    private uint CalculateIndex(uint rowIndex, uint columnIndex, uint rowWidth)
    {
        return rowIndex * rowWidth + columnIndex;
    }

    private uint GetColorFromPalette(uint colorIndex)
    {
        PR_WR_ByteBuffer colorBuffer = PR_WR_ByteBuffer.Create(4);
        colorBuffer.WriteUInt32LE(PR_WR_Palette.colors[colorIndex], 0);

        uint alpha = colorBuffer.ReadUInt8(3);
        uint red = colorBuffer.ReadUInt8(2);
        uint green = colorBuffer.ReadUInt8(1);
        uint blue = colorBuffer.ReadUInt8(0);

        return red | (green << 8) | (blue << 16) | (alpha << 24);
    }
}
