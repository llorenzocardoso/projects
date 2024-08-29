import { PROJECTS } from "../constants";
import { motion } from "framer-motion";

const Projects = () => {
  return (
    <div className="bg-neutral-100 py-20">
      <h2 className="my-20 text-center text-4xl text-gray-800">Projects</h2>
      <div className="flex flex-wrap justify-center gap-12">
        {PROJECTS.map((project, index) => (
          <motion.div 
            key={index}
            whileInView={{ opacity: 1, y: 0 }}
            initial={{ opacity: 0, y: 50 }}
            transition={{ duration: 0.6 }}
            className="bg-white shadow-lg rounded-lg p-6 max-w-md w-full"
          >
            <img
              src={project.image}
              alt={project.title}
              className="w-full h-48 object-cover rounded-md mb-4"
            />
            <h3 className="text-2xl font-semibold text-neutral-800 mb-2">{project.title}</h3>
            <p className="text-neutral-600 mb-4">{project.description}</p>
            <div className="flex flex-wrap gap-2">
              {project.technologies.map((tech, index) => (
                <span key={index} className="bg-neutral-200 text-neutral-700 rounded px-3 py-1 text-sm">
                  {tech}
                </span>
              ))}
            </div>
          </motion.div>
        ))}
      </div>
    </div>
  );
}

export default Projects;
