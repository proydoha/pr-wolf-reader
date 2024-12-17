class PR_WR_MapHead
{
    uint rlewTag;
    Array<uint> mapOffsets;

    static PR_WR_MapHead Create(uint rlewTag)
    {
        PR_WR_MapHead maphead = new("PR_WR_MapHead");
        maphead.rlewTag = rlewTag;

        return maphead;
    }
}
