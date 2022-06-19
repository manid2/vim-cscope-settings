" -- vim cscope settings
" Refer:
" * http://cscope.sourceforge.net/cscope_maps.vim
" * vim `:h cs-find`
if has("cscope")
	" use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
	set cscopetag
	" check symbol in ctags first and then cscope
	set csto=0
	" add any cscope db present in current directory else add from
	" CSCOPE_DB environment variable.
	if filereadable("cscope.out")
		cs add cscope.out
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	" show msg when any other cscope db added
	set cscopeverbose

	" cscope find command

	" set csope quickfix options to show cscope results in quickfix &
	" location list windows
	let s:csfindopts = ['s', 'g', 'd', 'c', 't', 'e', 'f', 'i']
	if has("quickfix")
		if (v:version > 800)
			let s:csfindopts += ['a']
		endif
		exe 'set cscopequickfix=' . join(s:csfindopts, '-,') . '-'
	endif

	" cscope keymaps
	for s:csfcmd in ['cs', 'scs', 'vert scs', 'lcs']
		let s:csfcmdkey='\'
		if s:csfcmd == 'scs'
			let s:csfcmdkey = ']'
		elseif s:csfcmd == 'vert scs'
			let s:csfcmdkey = "'"
		elseif s:csfcmd == 'lcs'
			let s:csfcmdkey = 'l'
		endif

		for s:csfopt in s:csfindopts
			let s:csfkeymap='nnoremap <Leader>'
			let s:csfkeymap .= s:csfcmdkey.s:csfopt.' :'.s:csfcmd.' find '.s:csfopt
			if s:csfopt == 'f'
				let s:csfkeymap .= ' <C-R>=expand("<cfile>")<CR><CR>'
			elseif s:csfopt == 'i'
				let s:csfkeymap .= ' <C-R>=expand("<cfile>")<CR>$<CR>'
			else
				let s:csfkeymap .= ' <C-R>=expand("<cword>")<CR><CR>'
			endif

			exe s:csfkeymap
		endfor
	endfor
endif

" vim:tw=78:ts=8:noet:ft=vim:norl:
