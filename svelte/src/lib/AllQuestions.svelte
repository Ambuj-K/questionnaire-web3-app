<script>
    import Question from "./Question.svelte";
    import {ethers} from 'ethers';
    export let web3Props = { 
        provider: null, 
        signer: null, 
        account: null, 
        chainId: null, 
        contract: null 
    };
    $: questions = null;
    async function getQuestions(){
        questions  = await web3Props.contract.getQuestions();
        web3Props.contract.on("QuestionCreated", (addr) => { 
            getQuestions();
        });
    }
    getQuestions();
</script>

{#if questions}
    <div class='qwrap'>
        {#each questions as questionAddr}
            <Question {questionAddr} {web3Props}/>
        {/each} 
    </div>
{/if}