<script>
    import {ethers} from 'ethers';
    import contractAbi from "../contracts/Questionnaire.json";
    let answer = null;
    let question = null;
    export let web3Props = { 
        provider: null, 
        signer: null, 
        account: null, 
        chainId: null, 
        contract: null 
    };
    export let questionAddr = null;
    $: question = null;
    $: value = null;
    $: funded = value > 0 ? 'question-funded' : 'question-not-funded';
    $: funding = 0;
    let qContract = null;
    async function getQuestion(){
        qContract = new ethers.Contract(questionAddr, contractAbi.abi, web3Props.signer);
        question = await qContract.question();
        value = Number(ethers.utils.formatEther(await web3Props.provider.getBalance(questionAddr)))
        qContract.on('QuestionnaireFunded', (balance) =>{
            value = Number(ethers.utils.formatEther(balance));
        });
        qContract.on('AnswerGuessed', () =>{
            getQuestion();
        });
    }
    async function submitGuess(){
        //TODO
        //modify contract from require to if, redeploy, and handle wrong answer event with message
        //for require failures, add comments, following protocols for function params
        await qContract.guess(answer, {
            gasLimit: 100000
        }); 
    }

    async function fund(){
        web3Props.signer.sendTransaction({
            to: questionAddr,
            value: ethers.utils.parseEther(funding)
        });
        funding = null;
    }
    getQuestion();
</script>

<div class="{funded} qwrap">
    <div class= "question">
        {question}
    </div>
    <div class= "value">
        {value} ETH
    </div>
    <input type="text" bind:value={answer} />
    <button on:click={submitGuess} disabled={value <= 0}>Submit Answer</button>
    <br>
    <input type="text" bind:value={funding} />
    <button on:click={fund}>Fund</button>
</div>