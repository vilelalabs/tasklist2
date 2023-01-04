<template>
    <div class="taskContainer">
        <input type="text" v-on:keydown.enter="checkEnterKey" v-model="newTask" class="task" />

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
    methods: {
        checkEnterKey() {
            if (this.task !== '') {
                this.$emit('closeAddNewTask', false)
                this.task.id = (Math.random(1, 99) * 100).toFixed(0)
                this.task.time = "00:00:00"
                this.task.task = this.newTask
                this.$emit('addTask', this.task)
                this.task = ''
            }
        }
    },
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