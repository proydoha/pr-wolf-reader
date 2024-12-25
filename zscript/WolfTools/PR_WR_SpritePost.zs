class PR_WR_SpritePost
{
    uint column;
    uint start;
    uint pixelPoolOffset;
    uint end;

    static PR_WR_SpritePost Create(uint column, uint start, uint pixelPoolOffset, uint end)
    {
        PR_WR_SpritePost post = new("PR_WR_SpritePost");

        post.column = column;
        post.start = start;
        post.pixelPoolOffset = pixelPoolOffset;
        post.end = end;

        return post;
    }
}
