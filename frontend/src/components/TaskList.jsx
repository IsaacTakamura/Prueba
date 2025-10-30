import { useState, useEffect } from "react";
import { useUser } from "@clerk/clerk-react";
import { useSupabaseClient } from "../hooks/useSupabaseClient";

export default function TaskList() {
  const { user } = useUser(); // esto me trae el usuario de clerk
  const { getClient } = useSupabaseClient();
  const [tasks, setTasks] = useState([]);
  const [title, setTitle] = useState("");

  // Cargar tareas del usuario
  useEffect(() => {
    const loadTasks = async () => {
      const supabase = await getClient();
      const { data, error } = await supabase.from("tasks").select("*");
      if (!error) setTasks(data);
    };
    loadTasks();
  }, []);

  // Crear tarea nueva
  const addTask = async () => {
    const supabase = await getClient();
    await supabase.from("tasks").insert({
      user_id: user.id,
      title,
    });
    setTitle("");
    const { data } = await supabase.from("tasks").select("*");
    setTasks(data);
  };

  const toggleTask = async (task) => {
    const supabase = await getClient();
    await supabase.from("tasks").update({
      completed: !task.completed
    }).eq('id', task.id);
    const { data } = await supabase.from("tasks").select("*");
    setTasks(data);
  };

  return (
    <div className="max-w-md mx-auto mt-8">
      <h2 className="text-xl font-bold mb-4">Mis tareas</h2>
      <div className="flex gap-2 mb-4">
        <input
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          placeholder="Nueva tarea"
          className="border p-2 flex-1 rounded"
        />
        <button
          onClick={addTask}
          className="bg-blue-600 text-white px-4 py-2 rounded"
        >
          Agregar
        </button>
      </div>

      <ul>
        {tasks.map((task) => (
          <li
            key={task.id}
            onClick={() => toggleTask(task)}
            className={`p-2 border-b cursor-pointer ${
              task.completed ? "line-through text-gray-500" : ""
            }`}
          >
            {task.title}
          </li>
        ))}
      </ul>
    </div>
  );
}
