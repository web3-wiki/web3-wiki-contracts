
# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

npm:; yarn install
install:; forge install OpenZeppelin/openzeppelin-contracts Rari-Capital/solmate
update:; forge update

# Build & test
build  :;  forge build --optimize 
watch  :;  forge build --watch
watch-test   :;  forge test --watch -vv
test   :; forge test --optimize
fuzz   :; forge test -v --optimize 
clean  :; forge clean
snapshot :; forge snapshot



slither :; slither ./src aa
format :; prettier --write src/**/*.sol && prettier --write src/*.sol

# solhint should be installed globally
lint :; solhint src/**/*.sol && solhint src/*.sol
# lint   :; yarn run lint

anvil :; anvil -m 'test test test test test test test test test test test junk'

