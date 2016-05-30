function fish_prompt
	# Glyphs
	set -l glyph_clubs \u2663
	set -l glyph_rightArrow \uE0B0
	set -l glyph_leftArrow \uE0B2
	set -l glyph_branch \uE0A0
	set -l glyph_sad \u26C8
	set -l glyph_happy ☀️
	set -l glyph_file \u2746

	# Colors
	set -l bg_red (set_color -b ad2a34)
	set -l bg_yellow (set_color -b d1b931)
	set -l bg_blue (set_color -b 28519e)
	set -l bg_green (set_color -b 49da3d)
	set -l red (set_color ad2a34)
	set -l red_light (set_color f20217)
	set -l yellow (set_color fee008)
	set -l glyph_yellow (set_color d1b931)
	set -l blue (set_color 28519e)
	set -l green (set_color 49da3d)
	set -l white (set_color FFFFFF)
	set -l normal (set_color normal)

	# Others
	set prompt_logo $bg_red $yellow ' '$glyph_clubs' ' $bg_yellow $red $glyph_rightArrow
	set prompt_pwd_def $bg_yellow $red ' '(pwd)' ' $normal $glyph_yellow $glyph_rightArrow' '
	set prompt_pwd_git $bg_yellow $red ' '(prompt_pwd)' ' $bg_blue $glyph_yellow $glyph_rightArrow

	echo -n -s $prompt_logo

	if [ (_git_branch) ]
		echo -n -s $prompt_pwd_git $bg_blue $yellow ' '$glyph_branch' '(_git_branch)' ' $bg_red $blue $glyph_rightArrow
		if [ (_git_has_changes) ]
			echo -n -s $bg_red ' '$glyph_sad'  '$bg_blue $red $glyph_rightArrow' '
		else
			echo -n -s $bg_red ' '$glyph_happy'  '$bg_blue $red $glyph_rightArrow' '
		end

		if [ (_git_has_untracked_files) ]
			echo -n -s $bg_blue $red_light $glyph_file'(+'(_git_has_untracked_files)') '
		else
			echo -n -s $bg_blue'  '
		end

		if [ (_git_has_unstaged_files) ]
			echo -n -s $bg_blue $yellow $glyph_file'(+'(_git_has_unstaged_files)') '
		else
			echo -n -s $bg_blue'  '
		end

		if [ (_git_has_staged_files) ]
			echo -n -s $bg_blue $green $glyph_file'(+'(_git_has_staged_files)')'
		else
			echo -n -s $bg_blue $green'  '
		end

		echo -n -s $normal $blue $glyph_rightArrow' '
	else
		echo -n -s $prompt_pwd_def
	end
end

function _git_branch
	echo (git rev-parse --abbrev-ref HEAD ^ /dev/null)
end

function _git_has_changes
	 echo (git status --porcelain ^/dev/null)
end

function _git_has_staged_files
	echo (git s --porcelain ^/dev/null | grep -c ".  ")
end

function _git_has_unstaged_files
	echo (git s --porcelain ^/dev/null | grep -c " . ")
end

function _git_has_untracked_files
	echo (git s --porcelain ^/dev/null | grep -c "??")
end