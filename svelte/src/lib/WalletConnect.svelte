<script>
    import {ethers} from 'ethers';
    export let web3Props = { provider: null, signer: null, account: null, chainId: null };
    async function connectWallet() {
        let provider = new ethers.providers.Web3Provider(window.ethereum, 'any');
        
        if (await provider.send('eth_requestAccounts,[]') === undefined)
        {console.log("get a wallet");}
        else
        {const signer = provider.getSigner();
        const account = await signer.getAddress();
        const chainId = await signer.getChainId();
        web3Props = { provider, signer, account, chainId };}
    }
</script>

<button on:click={connectWallet}>Attach Wallet</button>
