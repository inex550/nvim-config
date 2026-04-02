local function ends_with(str, ends)
    return ends == "" or string.sub(str, -#ends) == ends;
end

return {
    ends_with = ends_with;
}
