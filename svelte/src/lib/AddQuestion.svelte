<script>
    import {ethers} from 'ethers';
    export let web3Props = { 
        provider: null, 
        signer: null, 
        account: null, 
        chainId: null, 
        contract: null 
    };
    $: question = "";
    $: answer = "";
    $: hashedAnswer = '';

    async function addQuestion() {
        hashedAnswer = ethers.utils.keccak256(
            ethers.utils.solidityPack(
                ['bytes32','string'],
                [ethers.utils.formatBytes32String('190190190'), answer]
            )
        );
        web3Props.contract.createQuestionnaire(question,hashedAnswer);
    }
</script>

<div class='wrapper'>
    <span class="input-label">question:</span>
    <input bind:value={question}/>
    <span class="input-label">answer:</span>
    <input bind:value={answer}/>
    <button on:click={addQuestion}>Add Question</button>
</div>