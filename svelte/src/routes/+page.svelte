<script>
    import AddQuestion from "../lib/AddQuestion.svelte";
    import WalletConnect from "../lib/walletConnect.svelte";
    import contractAbi from "../contracts/QuestionnaireFactory.json";
    const contractAddr =  "0x1fE3E72Ad95cC796b91a6c3a976B0561440Ff32D";
    export let web3Props = {
        provider : null,
        signer : null,
        account : null,
        chainId : null
    };
</script>

<h1>Welcome to Questionnaire</h1>
{#if !web3Props.account}
<WalletConnect bind:web3Props {contractAddr} {contractAbi} />
{:else}
<AddQuestion bind:web3Props/>
{/if}
