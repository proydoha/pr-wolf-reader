class PR_WR_Sprite
{
    PR_WR_SpriteHeader header;
    Array<PR_WR_SpritePost> posts;

    static PR_WR_Sprite Create(PR_WR_ByteBuffer buffer)
    {
        PR_WR_Sprite sprite = new("PR_WR_Sprite");

        sprite.header = PR_WR_SpriteHeader.Create(buffer);

        uint bufferPosition = 4;
        for (int i = 0; i < sprite.header.columnOffsets.Size(); i++)
        {
            bufferPosition = sprite.header.columnOffsets[i];
            uint columnIndex = sprite.header.firstColumn + i;

            while (bufferPosition < buffer.Size())
            {
                uint doublePostEnd = buffer.ReadUInt16LE(bufferPosition);
                bufferPosition += 2;
                if (doublePostEnd == 0)
                {
                    break;
                }
                uint pixelPoolOffset = buffer.ReadUInt16LE(bufferPosition);
                bufferPosition += 2;
                uint doublePostStart = buffer.ReadUInt16LE(bufferPosition);
                bufferPosition += 2;

                uint postStart = Floor(double(doublePostStart) / 2);
                uint postEnd = Floor(double(doublePostEnd) / 2);

                sprite.posts.Push(PR_WR_SpritePost.Create(columnIndex, postStart, pixelPoolOffset, postEnd));
            }
        }

        return sprite;
    }
}
