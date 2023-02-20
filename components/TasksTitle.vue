<template>
    <div class="container">
        <p class="sel"> sel</p>
        <p class="id">id</p>
        <p class="task">Tarefa</p>
        <p class="time">tempo</p>
        <p class="action">ação</p>
    </div>
</template>

<script>
export default {
    name: 'TasksTitle',
}
</script>

<style scoped>
.container {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    border-radius: 0.5rem;
    margin: 1rem;
    background-color: white;
    color: #ddd;
    padding: 0.5rem;
    width: 100%;
    gap: 1.2rem;

    text-transform: uppercase;
    font-weight: bold;

}
.sel {
    width: 5%;
    padding-left: 0.5rem;
    text-align: center;
}
.id {
    width: 5%;
    text-align: center;
}
.task {
    width: 60%;
}
.time {
    width: 15%;
    text-align: center;
}
.action {
    width: 15%;
    text-align: center;
}

@media screen and (max-width: 480px) {
    .container{
        font-size: smaller;
    }
}
  
</style>