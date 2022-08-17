<script>
    import {ethers} from 'ethers';
    export let contractAddr = '';
    export let contractAbi = {abi : null};
    export let web3Props = { 
        provider: null, 
        signer: null, 
        account: null, 
        chainId: null, 
        contract: null 
    };
    
    async function connectWallet() {
        let provider = new ethers.providers.Web3Provider(window.ethereum, 'any');
        
        await provider.send('eth_requestAccounts',[]);
        const signer = provider.getSigner();
        const account = await signer.getAddress();
        const chainId = await signer.getChainId();
        const contract = new ethers.Contract(contractAddr, contractAbi.abi, signer);
        web3Props = { provider, signer, account, chainId, contract };
    }
</script>

<button on:click={connectWallet}>Attach Wallet</button>
