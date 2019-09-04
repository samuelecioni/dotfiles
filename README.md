gems dump
gem list --no-versions > gems

gems install from file dump
cat gems | xargs gem install
