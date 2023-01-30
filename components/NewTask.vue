<template>
    <div class="taskContainer">
        <input type="text" v-model="newTask" class="task" placeholder="Add a new task" @input="emitText">
    </div>
</template>

<script>
export default {
    name: 'TasksTitle',
    data() {
        return {
            task: [],
            newTask: ''
        }
    },
    methods:{
        emitText(){
            this.$emit('newTask', this.newTask)
        }
    }
}
</script>

<style scoped>
.taskContainer {
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: center;
    border-radius: 0.5rem;
    background-color: lightskyblue;
    color: #444;
    gap: 1rem;
    width: 100%;
    padding: 0.5rem;
    padding-left: 1rem;
    text-transform: uppercase;
    font-weight: bold;
    margin-block: 0.5rem;

}

.task {
    border: none;
    background-color: transparent;
    color: #444;
    font-size: 1rem;
    text-transform: uppercase;
    width: 100%;
}

.task:focus {
    outline: none;
}
</style>