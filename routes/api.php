<?php
  use Illuminate\Support\Facades\Route;
  use Illuminate\Http\Request;
  use App\Models\Project;
  
    Route::get('/projects', function () {
        return App\Models\Project::all();
    });

    Route::post('/test', function (Request $request) {

    $project = Project::create([
        'name' => $request->name,
        'version' => $request->version
    ]);

    return response()->json([
        'status' => true,
        'message' => 'Data inserted successfully 🚀',
        'data' => $project
    ]);
});