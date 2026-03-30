# usually these aliases are defined already in .bashrc
# alias ll='ls -alF'
# alias la='ls -A'
# alias l='ls -CF'
# alias l1='ls -1'

# alias lsa='ls -lah'
# alias l='ls -lh'
# alias ll='ls -lh'
# alias la='ls -lAh'
alias l1='ls -1'

############################## function: list files with perm number
# Show alias and its permissions in "number"
#
# Convert each permission into a number
#
# User Group Other
# rwx  rwx   rwx          filename
# to
# 777 rwxrwxrwx filename
function lll {
  ls -AlF |
    awk '
      BEGIN {
        # define permission mapping
        perm[0] = 0
        perm[1] = 1
        perm[2] = 2
        perm[3] = 3
        perm[4] = 4
        perm[5] = 5
        perm[6] = 6
        perm[7] = 7
      }
      {
        #skip the header line
        if (NR == 1) next

        # extract permission
        perms = substr($1, 2, 9)
        num_perm = 0
        for (i=1; i<=9; i+=3) {
          r = (substr(perms, i, 1) == "r") * 4
          w = (substr(perms, i+1, 1) == "w") * 2
          x = (substr(perms, i+2, 1) == "x")
          num_perm = num_perm * 10 + perm[r+w+x]
        }

        printf "%s  %s\n", num_perm, $0
  		}'
}
