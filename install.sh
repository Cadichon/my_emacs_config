
if [ $# -ne 1 ]
then
    echo "Please specify name.lastname"
    exit 1
fi


sed -i "s/USER/$1/g" .emacs.d/std_comment.el

mv .emacs ~
rm -rf .emacs.d/
mv -r .emacs.d/ ~

rm -rf $(pwd)
