class PR_MapHead
{
    uint rlewTag;
    Array<uint> levelOffsets;

    static PR_MapHead Create(uint rlewTag)
    {
        PR_MapHead maphead = new("PR_MapHead");
        maphead.rlewTag = rlewTag;

        return maphead;
    }
}
