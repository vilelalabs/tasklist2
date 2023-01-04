<template>
  <div class="container">
    <Title />
    <div class="buttonContainer">
      <button @click="handleAddNewTask">
        <Button color="blue" text="Adicionar Tarefa"></Button>
      </button>
      <button @click="handleDeleteTasks">
        <Button color="red" text="Remover Tarefa"></Button>
      </button>
    </div>

    <NewTask @closeAddNewTask="addNewTask = $event" @addTask="tasks.push($event)" v-if="addNewTask" task="new task" />
    <TasksTitle v-if="thereIsTasks" />
    <TasksContainer>
      <Task v-for="task in tasks" :key="task.id" :id="task.id" :task="task" :time="task.time" :taskName="task.task" />
    </TasksContainer>

  </div>
</template>

<script>
import Title from '@/components/Title.vue'
import Button from '@/components/Button.vue'
import TasksContainer from '@/components/TasksContainer.vue'
import TasksTitle from '@/components/TasksTitle.vue'
export default {
  name: 'IndexPage',
  components: {
    Title,
    Button,
    TasksTitle,
    TasksContainer,
  },
  methods: {
    handleAddNewTask() {
      this.addNewTask = true

    },
    handleDeleteTasks() {
      this.addNewTask = false
    },
  },
  data() {
    return {
      addNewTask: false,
      
      tasks: [],
    }
  },
  computed: {
    thereIsTasks() {
      if (this.tasks.length > 0) {
        return true
      } else {
        return false
      }
    }
  },
}
</script>

<style>
html {
  background-color: antiquewhite;
  margin: 0;
  padding: 0;
  font-family: 'Roboto', sans-serif;

}

.container {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border-radius: 0.5rem;
  margin: 1rem;

}

button {
  border: none;
  background-color: transparent;
  cursor: pointer;
}

.buttonContainer {
  display: flex;
  flex-direction: row;
  justify-content: flex-end;
  width: 100%;
  gap: 1.5rem;
}

p {
  margin: 0;
  padding: 0;
}
</style>