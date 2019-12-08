for f in split(glob('~/.config/nvim/custom/*.vim'), '\n')
    exe 'source' f
endfor
