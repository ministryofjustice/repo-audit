test:
	rspec && make mutant

# Run `make mutant` to mutation test all the things.
# To mutation test a specific class, run like this;
#
#     make mutant MUTATE=RepoAudit::Configuration
#
mutant:
	bundle exec mutant --fail-fast --use rspec $${MUTATE:-RepoAudit*}

# A quick and dirty alias to run the checks against a single repo
check:
	bin/check-repo.rb $${ORG:-ministryofjustice} $${REPO:-repo-audit} | python -m json.tool
