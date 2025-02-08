<?php

namespace App\Controller;

use App\Repository\TodoRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class ApiController extends AbstractController
{
    #[Route('/', name: 'app_api', methods: ['GET'])]
    public function index(TodoRepository $todoRepository): Response
    {
        return $this->render('api/index.html.twig', [
            'todos' => $todoRepository->findAllOrderedByDueDate()
        ]);
    }
}
