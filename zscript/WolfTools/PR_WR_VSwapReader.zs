class PR_WR_VSwapReader
{
    static PR_WR_VSwap Read(PR_WR_ByteBuffer buffer)
    {
        PR_WR_VSwap vswap = PR_WR_VSwap.Create(buffer);
        return vswap;
    }
}
